import '@fortawesome/fontawesome-free/js/fontawesome';
import '@fortawesome/fontawesome-free/js/solid';
import '@fortawesome/fontawesome-free/js/regular';
import '@fortawesome/fontawesome-free/js/brands';

import Rails from '@rails/ujs';
import UserMenu from './components/user-menu';
import Editor from './components/editor';

Rails.start();
UserMenu.start('.user-menu');
UserMenu.start('.nav-menu');
Editor.start('[data-provide="markdown"]');
