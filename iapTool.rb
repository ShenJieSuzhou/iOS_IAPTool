require 'spaceship'
require 'csv'

Spaceship::Tunes.login("helmut@januschka.com")
app = Spaceship::Application.find("hjanuschka.sticker-test")



def modify_iap_demo(app = nil)
  purch = app.in_app_purchases.find("spanish.app.idf.demo")
  e = purch.edit
  e.review_notes = "1Review Notes with atleast 10 characters"
  e.review_screenshot = "/Users/hja/Desktop/review.png"
  e.versions = {
        'en-US': {
          name: "Edit It1",
          description: "Description has at least 10 characters"
        },
        'es-ES': {
          name: "1test name es-ES",
          description: "German has at least 10 characters"
        },
        'es-US'
      }
  e.save!
end

def create_iap_demo(app = nil, filePath)

  p_array = parase_csv_file(filePath)

  for i in p_array do
    mode = p_array[i]
    create_iap(iapMode)
  end   
)

end

def create_iap(iapMode)
  app.in_app_purchases.create!(
    type: Spaceship::Tunes::IAPType::CONSUMABLE, 
    versions: {
      'es-ES': {
        name: "test name german1",
        description: "German has at least 10 characters"
      }
    },
    reference_name: "es_demo_es",
    product_id: "spanish.app.idf.demo",
    cleared_for_sale: true,
    review_notes: "Some Review Notes here bla bla bla",
    review_screenshot: "/Users/hja/Desktop/review.jpg", 
    pricing_intervals: 
    [
      {
        country: "WW",
        begin_date: nil,
        end_date: nil,
        tier: 1
      }
    ]  

end


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
    m_map["nme"] = m_productName
    m_map["id"] = m_productID
    m_map["type"] = m_type
    m_map["price"] = m_price
    m_map["describe"] = m_describe
  
    m_array << m_map
  end

  return m_array

end

parase_csv_file('/Users/shenjie/Desktop/ipaTest.csv')

# create_iap_demo(app)
























