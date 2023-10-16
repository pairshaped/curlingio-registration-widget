# ** THIS WIDGET IS NO LONGER SUPPORTED **

Please use our new registration and results widget instead:
<https://github.com/pairshaped/curlingio-results>


## Using the Widgets

To embed a widget in one of your pages, you simple copy and paste the javascript snippet below. There are two parameters that will need to be customized:

* `host`: Replace the `club-name` with your Curling I/O subdomain. For example, if your club's Curling I/O URL is `https://demo.curling.io` then that is what you would use for the `host` parameter.
* `section`: This can be `"leagues"`, `"competitions"`, or `"products"`. For example you might have three different pages on your website for each of these sections.

```
<script src="https://pairshaped.github.io/curlingio-registration-widget/prod.min.js"></script>
<div id="curlingio-leagues"></div>
<script>
  Elm.Main.init({
    node: document.getElementById("curlingio-leagues"),
    flags: { host: "https://club-domain.curling.io", section: "leagues" }
  })
</script>
```

## Development

To run the development environment:

`elm-app start`

## Deployment

First install uglify-js if you don't already have it:

`npm install -g uglify-js`

To compile, optimize, and minify for production:

`./prod.sh`

The widget script is hosted by this Github repo itself from the master branch.

All you need to do to deploy updates is run the prod script, commit the changes, and push to master.

## Source

<https://github.com/pairshaped/curlingio-registration-widget>
