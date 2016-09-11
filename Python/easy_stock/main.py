# -*- coding: utf-8 -*-

#---------------------------------import------------------------------------
import stk_download as download
import stk_calculate as calculate
import stk_drawK as drawK
import stk_strategy as strategy
#---------------------------------------------------------------------------


# 下载
'''
download.download_stk_list_to_csv()
download.download_all_stocks()

# 计算
calculate.trans_all_to_weekdata()
calculate.cal_all_week_ma()
'''
# 策略
strategy.all_week_ma_process()
