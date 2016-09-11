# -*- coding: utf-8 -*-

#---------------------------------import------------------------------------
import filemanager as fm
import pandas as pd
import stk_drawK as drawK
from pandas import Series
#---------------------------------------------------------------------------

####################
#     策略函数      #
####################

# 判断某只股票的5日均线是否突破20均线
def week_ma_process(sid):
    stock_data = pd.read_csv(fm.get_week_file(sid), skiprows = 0, parse_dates = True)
    # ma5
    ma5 = stock_data['ma5']
    ma60 = stock_data['ma20']
    if(ma5[1] > ma60[1]):
        if(ma5[2] < ma60[2]):
            print(sid + 'need confirm')


# 找出所有5日均线是否突破20均线的股票
def all_week_ma_process():
    stock_list = fm.get_week_sid_from_fold()
    for index, sid in enumerate(stock_list):
        week_ma_process(sid)
        if index % 100 == 0:
            print index