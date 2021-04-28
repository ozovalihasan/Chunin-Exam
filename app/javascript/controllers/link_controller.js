import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = [ "name", "output" ]

  shorten() {
    const content = this.nameTarget.value
    const  preview = this.outputTarget;
    Rails.ajax({
      type: "post",
      url: "/links",
      contentType: "text/plain",
      data: content,
      success: function(data) {
        preview.textContent = data
      }
    })
  }
}