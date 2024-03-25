// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

document.addEventListener("click", event => {
    const element = event.target.closest("[data-confirm]")

    if (element && !confirm(element.dataset.confirm)) {
        event.preventDefault()
    }
})
