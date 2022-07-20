/* eslint no-console:0 */

require("bootstrap")

import "../stylesheets/application";

document.addEventListener("turbolinks:load", function() {
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    })
})
