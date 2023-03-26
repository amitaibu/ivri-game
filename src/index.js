import { Elm } from "./elm/Main.elm";

Elm.Main.init({
    node: document.getElementById("root"),
    flags: {page: "item"},
});