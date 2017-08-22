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
