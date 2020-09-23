class WelcomeController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'

  def index
    trending = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/get-trending-tickers?region=US")

    httpTrending = Net::HTTP.new(trending.host, trending.port)
    httpTrending.use_ssl = true
    httpTrending.verify_mode = OpenSSL::SSL::VERIFY_NONE

    requestTrending = Net::HTTP::Get.new(trending)
    requestTrending["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    requestTrending["x-rapidapi-key"] = 'cdba148ea9msh63a70c57a3cf457p1d448ajsnaa9060146733'

    responseTrending = httpTrending.request(requestTrending)
    jsonResponse = JSON.parse(responseTrending.read_body)

    spark = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes?symbols=AMD%252CIBM%252CAAPL%252CTSLA%252CAMZN%252CNIO%252CMSFT%252CGOOG&region=US")

    http = Net::HTTP.new(spark.host, spark.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(spark)
    request["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    request["x-rapidapi-key"] = 'cdba148ea9msh63a70c57a3cf457p1d448ajsnaa9060146733'

    response = http.request(request)
    jsonResponseSpark = JSON.parse(response.read_body)

    summary = URI("https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-summary?region=US")

    httpSummary = Net::HTTP.new(summary.host, summary.port)
    httpSummary.use_ssl = true
    httpSummary.verify_mode = OpenSSL::SSL::VERIFY_NONE

    requestSummary = Net::HTTP::Get.new(summary)
    requestSummary["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
    requestSummary["x-rapidapi-key"] = 'cdba148ea9msh63a70c57a3cf457p1d448ajsnaa9060146733'

    responseSummary = http.request(requestSummary)
    jsonSummary = JSON.parse(responseSummary.read_body)

    @sparkStocks = jsonResponseSpark['quoteResponse']['result']
    @trendingStocks = jsonResponse['finance']['result'].first['quotes']
    @summaryStocks = jsonSummary['marketSummaryAndSparkResponse']['result']
  end
end
