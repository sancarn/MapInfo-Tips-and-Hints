# Creating nicely formatted IDs

```
update <tablename> set NamePicture = "Pic" & format$(rowid,string$(int(log(tableinfo("<tablename>",8))/log(10)),"0") & "#")
```
