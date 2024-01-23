library(polite)
library(dplyr)
library(rvest)
library(httr)

url<- 'https://www.amazon.com/Xiaomi-Version-8840mAh-Bluetooth-Speakers/dp/B0C9JXYHDV/ref=sr_1_2?crid=FFBXUBIKSLOB&keywords=xiaomi%2Bpad%2B6&qid=1706014916&sprefix=xiaomi%2Bpad%2B%2Caps%2C375&sr=8-2&th=1'

prod_des <- character(0)
price <- character(0)
reviews_num <- character(0)

web_scrape <- scrape(bow(url, user_agent = "Educational"))

prod_des <- web_scrape %>%
  html_nodes('span.a-size-large product-title-word-break') %>%
  html_text()

prod_des_df <- data.frame(Brand_Description = prod_des)
prod_des_df <- slice(prod_des_df, 1:3)
print(prod_des_df)

price <- web_scrape %>%
  html_nodes('span.a-offscreen') %>%
  html_text()

reviews_num <- web_scrape %>%
  html_nodes('span.a-size-base') %>%
  html_text()

review_stars <- web_scrape %>%
  html_nodes('span.a-icon-alt') %>%
  html_text()

min_length <- min(length(prod_des), length(price), length(reviews_num), length(review_stars))

product1_df <- data.frame(
  Product_Description = prod_des[1:min_length],
  Price = price[1:min_length],
  Number_of_Reviews = reviews_num[1:min_length],
  Review_Stars = review_stars[1:min_length]
)

print(product1_df)
