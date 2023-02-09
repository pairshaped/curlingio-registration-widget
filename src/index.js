import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';

Elm.Main.init({
  node: document.getElementById("curlingio-widget"),
  // flags: { host: "http://demo.curling.test:3000", section: "leagues" }
  flags: { host: "http://demo.curling.io", section: "leagues" }
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
