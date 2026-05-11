import { reactive } from 'vue';

interface AuthState {
  isLoggedIn: boolean;
  user: {
    id: number;
    name: string;
    email: string;
  } | null;
  token: string | null;
}

export const store = reactive<AuthState>({
  isLoggedIn: false,
  user: null,
  token: null,
});

export const AuthStore = {
  state: store,

  login(token: string, user: AuthState['user']) {
    this.state.isLoggedIn = true;
    this.state.user = user;
    this.state.token = token;
    localStorage.setItem('auth_token', token);
    localStorage.setItem('user', JSON.stringify(user));
  },

  logout() {
    this.state.isLoggedIn = false;
    this.state.user = null;
    this.state.token = null;
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user');
  },

  restore() {
    const token = localStorage.getItem('auth_token');
    const userStr = localStorage.getItem('user');

    if (token && userStr) {
      this.state.isLoggedIn = true;
      this.state.token = token;
      this.state.user = JSON.parse(userStr);
    }
  },
};
