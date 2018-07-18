require 'spaceship'
require 'csv'

Spaceship::Tunes.login("")
app = Spaceship::Application.find("")

# 批量修改被打回的商品
def modify_iap_demo(app = nil, filePath, str)

  #解析csv得到内购商品
  p_array = parase_csv_file(filePath)
  for mode in p_array do
    puts "正在修改商品 #{mode}"
    purch = app.in_app_purchases.find(mode["id"])
    e = purch.edit
    e.versions = {
        'zh-CN': {
          name: mode["name"],
          description: mode["describe"] + str
        }
      }
    e.save!
    puts "修改成功"
  end
  
end


# 批量创建商品
def create_iap(app = nil, iapMode)

  iapType = get_correct_iapType(iapMode["type"])

  tier = get_correct_price(iapMode["price"])

  product_name = iapMode["name"]

  product_id = iapMode["id"]

  description = iapMode["describe"] 

  puts "正在上传商品 #{iapMode}"
  app.in_app_purchases.create!(
    type: iapType, 
    versions: {
      'zh-CN': {
        name: product_name,
        description: description
      }
    },
    reference_name: product_name,
    product_id: product_id,
    cleared_for_sale: true,
    review_notes: " ",
    review_screenshot: "", 
    pricing_intervals: 
    [
      {
        country: "WW",
        begin_date: nil,
        end_date: nil,
        tier: tier
      }
    ]  
  )
  puts "上传成功"
end

# 获取到对应的商品类型
def  get_correct_iapType(type)
  if type == "消耗品"  
    return Spaceship::Tunes::IAPType::CONSUMABLE
  elsif type == "非消耗品"
    return Spaceship::Tunes::IAPType::NON_CONSUMABLE
  elsif type == "非自动续订"
    return Spaceship::Tunes::IAPType::NON_RENEW_SUBSCRIPTION
  elsif type == "自动续订"
    return Spaceship::Tunes::IAPType::RECURRING
  end

end


# 获取到对应的商品价格登记
def get_correct_price(price)
  # 分割字符串 去除价格中所带的tier
  tier = price.gsub("Tier", "")
  return tier.strip
end


# 解析 csv 文件，返回 商品信息 数组
def parase_csv_file(filePath)
  #数组用于存放解析过后的商品对象
  m_array = []
  
  #按行读取csv文件，并存放到数组中
  CSV.foreach(filePath, headers:true) do |row|
    #hash 对象，用于存放每一个商品的信息
    m_map = Hash.new

    # 获取所需数据
    m_productName = row[1]
    m_productID = row[2]
    m_type = row[3]
    m_price = row[4]
    m_describe = row[5]

    # key-value 设置
    m_map["name"] = m_productName
    m_map["id"] = m_productID
    m_map["type"] = m_type
    m_map["price"] = m_price
    m_map["describe"] = m_describe
  
    m_array << m_map
  end

  return m_array

end

# 开始创建ipa商品  
def create_iap_demo(app = nil, filePath)
  #解析csv得到内购商品
  p_array = parase_csv_file(filePath)

  #遍历创建商品
  mode = Hash.new
  for mode in p_array do
    create_iap(app, mode)
  end   

end

# 执行
create_iap_demo(app, '')
modify_iap_demo(app, '', '。')
























