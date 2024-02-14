import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="global-modal"
export default class extends Controller {
  connect() {}

  hideModalHandler() {
    this.element.remove();
  }

  submitHandler(event) {
    if (!event.detail.success) return;

    this.hideModalHandler();
  }
}
