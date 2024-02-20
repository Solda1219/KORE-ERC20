require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    moonbase: {
      url: 'https://rpc.api.moonbase.moonbeam.network', // Insert your RPC URL here
      chainId: 1287, // (hex: 0x507),
      accounts: ['f925f6975c5100f91b1bada3c9b3aecc6604753fd7d7c620ea3a43dff9611358'],
    },
  },
};
