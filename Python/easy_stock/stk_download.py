#-*- encoding: UTF-8 -*-
#---------------------------------import------------------------------------
import tushare as ts
import filemanager as fm
import pandas as pd
import os
import time
#---------------------------------------------------------------------------

####################
#   下载股票数据     #
####################

# 公共参数
stock_code_list = []

# 从网上获得所有股票列表
def download_stk_list_to_csv():
    df = ts.get_stock_basics()
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    df.to_csv(fm.stk_file_path + nowTime + 'list.csv')
    print 'stk list downloads ok'

# 从股票列表中读取股票代码
def read_stk_list_from_csv():
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    stock_list_data = pd.read_csv(fm.stk_file_path + nowTime + 'list.csv')
    raw_stock_code_list = stock_list_data['code']
    for index, code in enumerate(raw_stock_code_list):

        raw_sid = '000000' + str(code)
        sid = raw_sid[-6:]
        stock_code_list.append(sid)
        print(index)
    print 'code transfer finished'
    return stock_code_list


########## 主函数 ###########
# 从网上下载所有的csv
def download_all_stocks():
    stock_code_list = []
    stock_code_list = read_stk_list_from_csv()
    print(stock_code_list)
    finished_count = 0
    for index, code in  enumerate(stock_code_list):
        df = ts.get_hist_data(code)
        try:
            df.to_csv(fm.get_csv_fold() + '/' + code + '.csv')
        except:
            print code
            continue
    print 'all download finished'