let started = {};

export default class UserMenu {
  constructor(className = '.user-menu') {
    this.className = className;
    this.onClick = this.onClick.bind(this);
  }

  static start(className = '.user-menu') {
    if (!started[className]) {
      document.addEventListener('DOMContentLoaded', function() {
        new UserMenu(className).attach();
      });
      started[className] = true;
    }
  }

  attach() {
    const menuToggle = document.querySelector(`${this.className}-dropdown-toggle`);

    if (menuToggle) {
      menuToggle.addEventListener('click', this.onClick);
    }
  }

  detach() {
    const menuToggle = document.querySelector(`${this.className}-dropdown-toggle`);

    if (menuToggle) {
      menuToggle.removeEventListener('click', this.onClick);
    }
  }

  onClick() {
    const menuDropdown = document.querySelector(`${this.className}-dropdown`);

    if (menuDropdown.classList.contains('shown')) {
      menuDropdown.classList.replace('shown', 'hidden');
    } else {
      menuDropdown.classList.replace('hidden', 'shown');
    }
  }
}
