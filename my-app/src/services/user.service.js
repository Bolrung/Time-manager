import axios from 'axios';
import authHeader from './auth-header';

const URL = 'http://localhost:8080/api/';

class UserService {
  getPublicContent() {
    return axios.get(URL + 'all');
  }

  getUserBoard() {
    return axios.get(URL + 'user', { headers: authHeader() });
  }

  getManagerBoard() {
    return axios.get(URL + 'man', { headers: authHeader() });
  }

  getGeneralBoard() {
    return axios.get(URL + 'admin', { headers: authHeader() });
  }
}

export default new UserService();