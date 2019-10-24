import '@fortawesome/fontawesome-free/js/fontawesome';
import '@fortawesome/fontawesome-free/js/solid';
import '@fortawesome/fontawesome-free/js/regular';
import '@fortawesome/fontawesome-free/js/brands';
import "../css/application.css";

import Rails from '@rails/ujs';
import UserMenu from '../js/user-menu';
import Editor from '../js/editor';

Rails.start();
UserMenu.start('.user-menu');
UserMenu.start('.nav-menu');
Editor.start('[data-provide="markdown"]');
