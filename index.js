const axios = require('axios');

let yourAPIKey = "43mKUgcLH6NSL6qe1lskxFgmwQxs9N2u";

const url = `https://scroll-mainnet.g.alchemy.com/v2/${yourAPIKey}`;

const payload = {
  jsonrpc: '2.0',
  id: 1,
  method: 'eth_blockNumber',
  params: []
};

axios.post(url, payload)
  .then(response => {
    console.log('Block Number:', response.data.result);
  })
  .catch(error => {
    console.error(error);
  });