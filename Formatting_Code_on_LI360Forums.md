# LI360 Formatting

Formatting code in [MapInfo user forums](li360.pitneybowes.com)

Create a debug point on line:
File:   aura_prod.js:formatted
Line:	13438

Within the try statement:

	var H;
	try {
		var N = {
			message: $A.util.za.ob({
				actions: f
			}),
			"aura.context": PG(n, c === Em)
		};
		c === Hj ? N[ms] = lp : N[ns] = this.Ac;
		H = JK(N)	//<-- INSERT BREAK POINT HERE
		} catch (W) {
		for (t = 0; t < b.length; t++)
		k = b[t],
		xJ(k, W),
		k.mc(n);
		$A.error(Ov + f[0], W);
		return u
	}

While in debug mode:

	msg=JSON.parse(N.message)
	sgmnts = msg.actions[0].params.commentInput.body.messageSegments
	//modify object as you see fit
	//	to type code use {type: "MarkupBegin", markupType: "Code"}

Now, you simply have to modify the original property of the object N!

	N.message = JSON.stringify(msg)
	
	
	
-------

Can't get this to work anymore 28 October 2017

However, if we go to the website and open up the javascript console you can access the `$A` variable.

You can then stringify the object with this code:

```js
// Note: cache should not be re-used by repeated calls to JSON.stringify.
var cache = [];
s = JSON.stringify(o, function(key, value) {
    if (typeof value === 'object' && value !== null) {
        if (cache.indexOf(value) !== -1) {
            // Circular reference found, discard key
            return;
        }
        // Store value in our collection
        cache.push(value);
    }
    return value;
});
cache = null; // Enable garbage collection
console.log(s)
```

With this string we can search for `isCodeSnippetUserPermEnabled` and will see that all 14 instances are set to false!

```
{"componentDef":{"descriptor":"markup://forceCommunity:omniBox"},"creationPath":"/*[0]/$/$/*[1]/*[0]/$/*[0]/search[0]/*[0]/*[0]","model":{"chatterEnabled":true,"defaultTopic":{"children":[],"id":"0mt80000000GmbwAAC","managedTopicType":"Navigational","parent":null,"topic":{"createdDate":"2017-04-08T04:31:53.000Z","description":null,"id":"0TO800000009An3GAE","images":{"coverImageUrl":"/servlet/servlet.ImageServer?id=01580000002Mfdx&oid=00D80000000KkyB&lastMod=1500586434000","featuredImageUrl":"/servlet/servlet.ImageServer?id=01580000002Mfcz&oid=00D80000000KkyB&lastMod=1500585538000"},"isBeingDeleted":false,"name":"Product \"How To\" Content","nonLocalizedName":"Product \"How To\" Content","talkingAbout":4,"url":"/services/data/v41.0/connect/communities/0DB80000000L2J0GAK/topics/0TO800000009An3GAE"},"url":"/services/data/v41.0/connect/communities/0DB80000000L2J0GAK/managed-topics/0mt80000000GmbwAAC"},"guestUser":false,"hideDeflection":false,"isQuestionVotingEnabled":false,"isTopicsEnabled":true,"readOnly":false,"richTextConfig":{"isRichTextEnabled":true,"isCodeSnippetUserPermEnabled":false,"isQuillEditorEnabled":true,"isEmojiPermEnabled":true}
...
```

```
[],"Mf":true},"markup://forceChatter:editManager":{"g":{"prefix":"markup","ag":"forceChatter","name":"editManager","Si":"forceChatter:editManager","P":"markup://forceChatter:editManager"},"Yg":false,"ic":"I","jj":{},"lj":false,"wp":null,"gd":{},"si":[],"ti":[{"action":{"exprType":"PROPERTY","byValue":false,"path":"c.editItem"},"eventDef":{"g":{"prefix":"markup","ag":"force","name":"editFeedItem","Si":"force:editFeedItem","P":"markup://force:editFeedItem"},"On":{"data":["data","java://sfdc.chatter.connect.api.output.feeds.FeedItemRepresentation","I",true,null],"richTextConfig":["richTextConfig","aura://Map","I",false,{"isRichTextEnabled":false,"isCodeSnippetUserPermEnabled":false}]
...
```

```
{"name":"change","action":{"exprType":"PROPERTY","byValue":false,"path":"c.updateErrorBanner"},"value":{"exprType":"PROPERTY","byValue":false,"path":"v.pageErrors"}},{"name":"init","action":{"exprType":"PROPERTY","byValue":false,"path":"c.init"},"value":{"exprType":"PROPERTY","byValue":false,"path":"this"}}],"mj":false,"Bo":true,"Ub":{"A":{"body":{"g":{"prefix":"markup","ag":"forceChatter","name":"body","Si":"body","P":"markup://body"},"pd":"aura://Aura.Component[]","ic":"G","required":false,"defaultValue":[]},"publisherFeedType":{"g":{"prefix":"markup","ag":"forceChatter","name":"publisherFeedType","Si":"publisherFeedType","P":"markup://publisherFeedType"},"pd":"aura://String","ic":"I","required":true},"publisherId":{"g":{"prefix":"markup","ag":"forceChatter","name":"publisherId","Si":"publisherId","P":"markup://publisherId"},"pd":"aura://String","ic":"I","required":false},"hasPublisherTopics":{"g":{"prefix":"markup","ag":"forceChatter","name":"hasPublisherTopics","Si":"hasPublisherTopics","P":"markup://hasPublisherTopics"},"pd":"aura://Boolean","ic":"I","required":false,"defaultValue":false},"richTextConfig":{"g":{"prefix":"markup","ag":"forceChatter","name":"richTextConfig","Si":"richTextConfig","P":"markup://richTextConfig"},"pd":"aura://Map","ic":"I","required":false,"defaultValue":{"isRichTextEnabled":false,"isCodeSnippetUserPermEnabled":false}}
```

```
"markup://forceChatter:textPost":{"g":{"prefix":"markup","ag":"forceChatter","name":"textPost","Si":"forceChatter:textPost","P":"markup://forceChatter:textPost"},"Yg":false,"ic":"I","jj":{},"lj":false,"wp":null,"gd":{},"si":["publisherStateChange","notify","publisherQuickActionMainContentRendered"],"ti":null,"Ai":null,"Vj":null,"mj":false,"Ub":{"A":{"body":{"g":{"prefix":"markup","ag":"forceChatter","name":"body","Si":"body","P":"markup://body"},"pd":"aura://Aura.Component[]","ic":"G","required":false,"defaultValue":[]},"publisherFeedType":{"g":{"prefix":"markup","ag":"forceChatter","name":"publisherFeedType","Si":"publisherFeedType","P":"markup://publisherFeedType"},"pd":"aura://String","ic":"I","required":true},"publisherId":{"g":{"prefix":"markup","ag":"forceChatter","name":"publisherId","Si":"publisherId","P":"markup://publisherId"},"pd":"aura://String","ic":"I","required":false},"hasPublisherTopics":{"g":{"prefix":"markup","ag":"forceChatter","name":"hasPublisherTopics","Si":"hasPublisherTopics","P":"markup://hasPublisherTopics"},"pd":"aura://Boolean","ic":"I","required":false,"defaultValue":false},"richTextConfig":{"g":{"prefix":"markup","ag":"forceChatter","name":"richTextConfig","Si":"richTextConfig","P":"markup://richTextConfig"},"pd":"aura://Map","ic":"I","required":false,"defaultValue":{"isRichTextEnabled":false,"isCodeSnippetUserPermEnabled":false}}
...
```

Etc.

Perhaps by changing these values we can activate the code editor



