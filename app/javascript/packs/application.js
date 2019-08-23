import '@fortawesome/fontawesome-free/js/fontawesome';
import '@fortawesome/fontawesome-free/js/solid';
import '@fortawesome/fontawesome-free/js/regular';
import '@fortawesome/fontawesome-free/js/brands';
import "../css/application.css";

import Rails from 'rails-ujs';
import UserMenu from '../js/user-menu';

Rails.start();
UserMenu.start();
