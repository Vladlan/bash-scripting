import { Config } from './config.interface';

export const environment: Config = {
  production: true,
  apiEndpoints: {
    product: 'http://192.168.0.3/api',
    order: 'http://192.168.0.3/api',
    import: 'http://192.168.0.3/api',
    bff: 'http://192.168.0.3/api',
    cart: 'http://192.168.0.3/api',
  },
  apiEndpointsEnabled: {
    product: true,
    order: true,
    import: true,
    bff: true,
    cart: true,
  },
};
