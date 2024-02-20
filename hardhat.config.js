require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    moonbase: {
      url: 'https://rpc.api.moonbase.moonbeam.network', // Insert your RPC URL here
      chainId: 1287, // (hex: 0x507),
      accounts: ['c2f7c0ce784c919549d450a05d38b58b3a48bccfc22e8b8d58fda8aa31532581'],
    },
  },
};
