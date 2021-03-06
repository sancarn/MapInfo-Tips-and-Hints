;############################################################################
;#                              AHK Template                                #
;############################################################################

AppName 	:= ""
Description 	:= ""
Developer 	:= ""
CoDevelopers 	:= ""

;Standard environment variables:
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Singleinstance,force

;Securing Intellectual Property
If !HashString(A_IPAddress1,6) = "BC911C34051D0523314A9C121D06D4907FC4A91ED73312C9A87D6F5AC969095DE7A7C88D43CEA88CED5888DF1D0D01D8A2F13A0313FED05362626260E009DD51" {
	Msgbox, % 4096+16, %AppName% , An error occurred during initiation. `r`nError: -9999
	ExitApp
}

	;Get the ACTIVE Mapinfo 64-Bit COM Object.
	MI := ComObjActive("MapInfo.Application.x64")

	MITables:=""

	numtabs := MI.Eval("numtables()")
	Loop, %numtabs% {
		cmd = tableinfo(%A_Index%,1)
		MITables := MITables . (A_Index=1 ? "" : "|" ) . MI.Eval(cmd)
	}


	;  Your   code   here
	Gui,Font,Normal s14 c0x0,Tahoma
	Gui,Add,DropDownList,x16 y35 w250 h160 Sort vsTableName gGetColumns,%MITables%
	Gui,Add,DropDownList,x16 y95 w250 h160 Sort vsColumnName,ColumnNames
	Gui,Add,Button,x40 y150 w80 h35 gExecute,OK
	Gui,Add,Button,x157 y150 w80 h35 gCancelPress,Cancel
	Gui,Font,Normal s12 c0x0,Tahoma
	Gui,Add,Text,x18 y14 w140 h20,Select table name:
	Gui,Add,Text,x17 y74 w160 h20,Select column name:
	Gui,Show,x462 y166 w286 h201 ,
Return

GetColumns:
	GUIControlGet,sTableName
	MIColumns := ""
	cmd = numcols("%sTableName%")
	numcols := MI.Eval(cmd) 
	Loop, %numcols% {
		cmd = ColumnInfo("%sTableName%","COL%A_Index%",1)
		MIColumns := MIColumns . (A_Index=1 ? "" : "|" ) . MI.Eval(cmd)
	}
	GuiControl,Text,sColumnName,
	GuiControl,Text,sColumnName,%MIColumns%
Return

CancelPress:
GuiClose:
ExitApp
return

Execute:
;Name of table to search through
tabName := sTableName

;Get the number of rows from mapinfo
numRows := MI.Eval("tableinfo(" . tabName . ",8)")

intro = 
(
Press the right button to go to the next plan.
Press the left button to go to the previous plan.
Press the enter button to take a screen shot.
Press alt+esc when done to close AutoPlan.
)

TrayTip, AutoPlan, %intro% , 0.1, 16+1

i:=0
return


;Make sure MapInfo 64-Bit is Open
#IfWinActive, ahk_exe MapInfoPro.exe

Right::
	i := i + 1
	if (i > numRows) {
		i = 1
	} else if (i<1) {
		i:=numRows
	}
	
	;Setup command
	cmd = close table selection  select * from %tabName% where rowid = %i% into SelectedNode  run menu command 306  run menu command 304  Print chr$(12) & %i%
	
	;Run command in mapinfo
	MI.Do(cmd)
	j:=0
return

Left::
	i := i - 1
	if (i > numRows) {
		i = 1
	} else if (i<1) {
		i:=numRows
	}
	
	cmd = close table selection  select * from %tabName% where rowid = %i% into SelectedNode  run menu command 306  run menu command 304  Print chr$(12) & %i%
	MI.Do(cmd)
	j:=0
return

enter::
	cmd = fetch first from SelectedNode Save Window FrontWindow() As "%A_WorkingDir%\" & SelectedNode.col1 & "_%j%" & ".png" Type "PNG"
	MI.Do(cmd)
	j := j + 1
	TrayTip, AutoPlan, Screenshot taken, 0.1, 16+1
return

!esc::
	TrayTip, AutoPlan, Autoplan has quit., 0.1, 16+1
	ExitApp
return


























/*
HASH types:
1 - MD2
2 - MD5
3 - SHA
4 - SHA256 - not supported on XP,2000
5 - SHA384 - not supported on XP,2000
6 - SHA512 - not supported on XP,2000
*/
HashFile(filePath,hashType=2)
{
	PROV_RSA_AES := 24
	CRYPT_VERIFYCONTEXT := 0xF0000000
	BUFF_SIZE := 1024 * 1024 ; 1 MB
	HP_HASHVAL := 0x0002
	HP_HASHSIZE := 0x0004
	
	HASH_ALG := hashType = 1 ? (CALG_MD2 := 32769) : HASH_ALG
	HASH_ALG := hashType = 2 ? (CALG_MD5 := 32771) : HASH_ALG
	HASH_ALG := hashType = 3 ? (CALG_SHA := 32772) : HASH_ALG
	HASH_ALG := hashType = 4 ? (CALG_SHA_256 := 32780) : HASH_ALG	;Vista+ only
	HASH_ALG := hashType = 5 ? (CALG_SHA_384 := 32781) : HASH_ALG	;Vista+ only
	HASH_ALG := hashType = 6 ? (CALG_SHA_512 := 32782) : HASH_ALG	;Vista+ only
	
	f := FileOpen(filePath,"r","CP0")
	if !IsObject(f)
		return 0
	if !hModule := DllCall( "GetModuleHandleW", "str", "Advapi32.dll", "Ptr" )
		hModule := DllCall( "LoadLibraryW", "str", "Advapi32.dll", "Ptr" )
	if !dllCall("Advapi32\CryptAcquireContextW"
				,"Ptr*",hCryptProv
				,"Uint",0
				,"Uint",0
				,"Uint",PROV_RSA_AES
				,"UInt",CRYPT_VERIFYCONTEXT )
		Goto,FreeHandles
	
	if !dllCall("Advapi32\CryptCreateHash"
				,"Ptr",hCryptProv
				,"Uint",HASH_ALG
				,"Uint",0
				,"Uint",0
				,"Ptr*",hHash )
		Goto,FreeHandles
	
	VarSetCapacity(read_buf,BUFF_SIZE,0)
	
    hCryptHashData := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptHashData", "Ptr")
	While (cbCount := f.RawRead(read_buf, BUFF_SIZE))
	{
		if (cbCount = 0)
			break
		
		if !dllCall(hCryptHashData
					,"Ptr",hHash
					,"Ptr",&read_buf
					,"Uint",cbCount
					,"Uint",0 )
			Goto,FreeHandles
	}
	
	if !dllCall("Advapi32\CryptGetHashParam"
				,"Ptr",hHash
				,"Uint",HP_HASHSIZE
				,"Uint*",HashLen
				,"Uint*",HashLenSize := 4
				,"UInt",0 ) 
		Goto,FreeHandles
		
	VarSetCapacity(pbHash,HashLen,0)
	if !dllCall("Advapi32\CryptGetHashParam"
				,"Ptr",hHash
				,"Uint",HP_HASHVAL
				,"Ptr",&pbHash
				,"Uint*",HashLen
				,"UInt",0 )
		Goto,FreeHandles	
	
	SetFormat,integer,Hex
	loop,%HashLen%
	{
		num := numget(pbHash,A_index-1,"UChar")
		hashval .= substr((num >> 4),0) . substr((num & 0xf),0)
	}
	SetFormat,integer,D
		
FreeHandles:
	f.Close()
	DllCall("FreeLibrary", "Ptr", hModule)
	dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
	dllCall("Advapi32\CryptReleaseContext","Ptr",hCryptProv,"UInt",0)
	return hashval
}

hashString(someString, hashType = 2){
FileAppend,someString, %A_Temp%\HashString.str
	returnStr := HashFile(A_Temp . "\HashString.str", hashType)
FileDelete,%A_Temp%\HashString.str
return returnStr
}
