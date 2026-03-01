import axios from 'axios';

const API_BASE = '/api';

const client = axios.create({
  baseURL: API_BASE,
  headers: { 'Content-Type': 'application/json' },
});

client.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export const authApi = {
  register: (data) => client.post('/auth/register', data),
  login: (data) => client.post('/auth/login', data),
  checkEmail: (email) => client.get('/auth/check-email', { params: { email } }),
};

export const jobsApi = {
  getAll: () => client.get('/jobs'),
  getById: (id) => client.get(`/jobs/${id}`),
  apply: (application, resume) => {
    const formData = new FormData();
    formData.append('application', new Blob([JSON.stringify(application)], { type: 'application/json' }));
    if (resume) formData.append('resume', resume);
    return client.post('/jobs/apply', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
  getMyApplications: () => client.get('/jobs/my-applications'),
};

export const scholarshipsApi = {
  getAll: () => client.get('/scholarships'),
  getById: (id) => client.get(`/scholarships/${id}`),
  apply: (application, coverLetter) => {
    const formData = new FormData();
    formData.append('application', new Blob([JSON.stringify(application)], { type: 'application/json' }));
    if (coverLetter) formData.append('coverLetter', coverLetter);
    return client.post('/scholarships/apply', formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },
  getMyApplications: () => client.get('/scholarships/my-applications'),
};

export const usersApi = {
  getMe: () => client.get('/users/me'),
};

export default client;
