#!/usr/bin/env python3

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from time import sleep

f=open("extra-data/11_username.txt")
login_info=f.read().split("\n")
f.close()

browser = webdriver.Chrome('extra-data/12_chromedriver')

browser.implicitly_wait(1)

browser.get('https://www.instagram.com/')

sleep(1)
username_input = browser.find_element_by_css_selector("input[name='username']")
password_input = browser.find_element_by_css_selector("input[name='password']")

username_input.send_keys(login_info[0])
password_input.send_keys(login_info[1])

login_button = browser.find_element_by_xpath("//button[@type='submit']")
login_button.click()

sleep(2)
browser.find_element_by_xpath('//button[normalize-space()="Not Now"]').click()
sleep(1)
browser.find_element_by_xpath('//button[normalize-space()="Not Now"]').click()

#searchbox
sleep(2)
searchbox=browser.find_element_by_css_selector("input[placeholder='Search']")
searchbox.clear()
searchbox.send_keys("realitygayspodcast ")
sleep(2)
searchbox.send_keys(Keys.ENTER)
sleep(2)
searchbox.send_keys(Keys.ENTER)
sleep(2)
browser.find_element_by_xpath('//button[normalize-space()="Follow"]').click()
sleep(2)
browser.quit()
