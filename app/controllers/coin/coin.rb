module Coin
  require 'coingecko_ruby'

  def Coin.add_btc
    client = CoingeckoRuby::Client.new
    @bitcoin_dolar_price = client.price('bitcoin')['bitcoin']['usd']
  end

  def Coin.add_eth
    client = CoingeckoRuby::Client.new
    @ethereum_dolar_price = client.price('ethereum')['ethereum']['usd']
  end

  def Coin.add_axs
    client = CoingeckoRuby::Client.new
    @ethereum_dolar_price = client.price('axie-infinity')['axie-infinity']['usd']
  end

  def Coin.add_slp
    client = CoingeckoRuby::Client.new
    @ethereum_dolar_price = client.price('smooth-love-potion')['smooth-love-potion']['usd']
  end

  def Coin.add_ron
    client = CoingeckoRuby::Client.new
    @ethereum_dolar_price = client.price('ronin')['ronin']['usd']
  end

end
