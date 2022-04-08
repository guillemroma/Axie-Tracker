class Coin
  require 'coingecko_ruby'
  attr_accessor :btc, :eth, :axs, :slp, :ron
  def initialize()
    @btc = 0,
    @eth = 0,
    @axs = 0,
    @slp = 0,
    @ron = 0
  end

  def add_btc
    client = CoingeckoRuby::Client.new
    @bitcoin_dolar_price = client.price('bitcoin')['bitcoin']['usd']
  end

  def add_eth
    client = CoingeckoRuby::Client.new
    @ethereum_dolar_price = client.price('ethereum')['ethereum']['usd']
  end

  def add_axs
    client = CoingeckoRuby::Client.new
    @axs_dolar_price = client.price('axie-infinity')['axie-infinity']['usd']
  end

  def add_slp
    client = CoingeckoRuby::Client.new
    @slp_dolar_price = client.price('smooth-love-potion')['smooth-love-potion']['usd']
  end

  def add_ron
    client = CoingeckoRuby::Client.new
    @ron_dolar_price = client.price('ronin')['ronin']['usd']
  end

end
