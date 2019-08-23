let started = false;

export default class UserMenu {
  constructor(className = '.user-menu') {
    this.className = className;
    this.onClick = this.onClick.bind(this);
  }

  static start() {
    if (!started) {
      document.addEventListener('DOMContentLoaded', function() {
        new UserMenu().attach();
      });
      started = true;
    }
  }

  attach() {
    const userMenuToggle = document.querySelector('.user-menu-dropdown-toggle');

    if (userMenuToggle) {
      userMenuToggle.addEventListener('click', this.onClick);
    }
  }

  detach() {
    const userMenuToggle = document.querySelector('.user-menu-dropdown-toggle');

    if (userMenuToggle) {
      userMenuToggle.removeEventListener('click', this.onClick);
    }
  }

  onClick() {
    const userMenu = document.querySelector('.user-menu-dropdown');

    if (userMenu.classList.contains('shown')) {
      userMenu.classList.replace('shown', 'hidden');
    } else {
      userMenu.classList.replace('hidden', 'shown');
    }
  }
}
