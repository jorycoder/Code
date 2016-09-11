# -*- coding: utf-8 -*-

#---------------------------------import------------------------------------
import filemanager as fm
import pandas as pd
from pandas import Series
#---------------------------------------------------------------------------

####################
#   日线转换为周线   #
####################


# 将一只股票的日数据转化为周数据,并保存到本地
def day_to_week(sid):
    # 读取本地数据
    stock_data = pd.read_csv(fm.get_csv_file(sid), skiprows = 0, parse_dates = True)
    # 设定转换的周期period_type，转换为周是'W'，月'M'，季度线'Q'，五分钟是'5min'，12天是'12D'
    stock_data.index=pd.to_datetime(stock_data['date'])
    period_type = 'W'

    # 进行转换，周线的每个变量都等于那一周中最后一个交易日的变量值
    period_stock_data = stock_data.resample(period_type).last()

    # 周线的【open】等于那一周中第一个交易日的【open】
    period_stock_data['open'] = stock_data['open'].resample(period_type).first()
    # 周线的【high】等于那一周中【high】的最大值
    period_stock_data['high'] = stock_data['high'].resample(period_type).max()
    # 周线的【low】等于那一周中【low】的最小值
    period_stock_data['low'] = stock_data['low'].resample(period_type).min()
    # 周线的【volume】和【money】等于那一周中【volume】和【money】各自的和
    period_stock_data['volume'] = stock_data['volume'].resample(period_type).sum()
    period_stock_data['turnover'] = stock_data['turnover'].resample(period_type).sum()

    # 股票在有些周一天都没有交易，将这些周去除
    period_stock_data = period_stock_data[period_stock_data['open'].notnull()]

    ''' 计算均线系统 '''
    # 分别计算5日、20日、60日的移动平均线
    ma_list = [5, 10, 20]

    # 计算简单算术移动平均线MA - 注意：stock_data['close']为股票每天的收盘价
    for ma in ma_list:
         period_stock_data['ma' + str(ma)] = period_stock_data['close'].rolling(window= ma).mean()#pd.rolling_mean(stock_data['close'], ma)

     # 将数据按照交易日期从近到远排序
    period_stock_data.sort_values('date', ascending=False, inplace=True)

    # ========== 将计算好的周线数据period_stock_data输出到csv文件
    period_stock_data.to_csv(fm.get_week_file(sid))

# 将所有股票的日数据转化为周数据,并保存到本地
def trans_all_to_weekdata():
    stk_list = fm.get_sid_from_fold()
    for index,sid in enumerate(stk_list):
        day_to_week(sid)
        if index % 100 == 0:
            print(index / 100 )
    print('transform finish')


def week_ma_process(sid):
    stock_data = pd.read_csv(fm.get_week_file(sid), skiprows = 0, parse_dates = True)
    # ma5
    ma5 = stock_data['ma5']
    ma60 = stock_data['ma20']
    if(ma5[1] > ma60[1]):
        if(ma5[2] < ma60[2]):
            print(sid + 'need confirm')

def cal_all_week_ma():
    stock_list = fm.get_week_sid_from_fold()
    for index, sid in enumerate(stock_list):
        week_ma_process(sid)
        if index % 100 == 0:
            print index
