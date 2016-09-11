# -*- coding: utf-8 -*-

#---------------------------------import------------------------------------
import os
import time
#---------------------------------------------------------------------------


#总路径
stk_file_path = '/Users/Qili/Desktop/abc/'

#############################
#     公共类,管理所有文件     #
############################

########### 共有方法 ###############
# 创建子文件夹(main)
def creat_fold(path, filename):
    isFoldExist = os.path.exists(path + filename)
    if(isFoldExist):
        pass
    else:
        os.makedirs(path + filename)
    return (path + filename + '/')




########## 单日数据 ############
# 返回今天日期
def get_today_date():
    return time.strftime("%Y-%m-%d",time.localtime(time.time()))
# 获取当天总目录
def get_today_fold():
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    return creat_fold(stk_file_path, nowTime)

# 获取源csv文件夹
def get_csv_fold():
    # 同一天下载的用这个文件夹这个文件夹
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    return creat_fold(stk_file_path, nowTime + '/sourcecsv')

# 获取csv文件路径
def get_csv_file(sid):
    return get_csv_fold() + '/' + sid + '.csv'

#  获取图片文件夹
def get_img_fold():
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    return creat_fold(stk_file_path, nowTime + 'kLine')

# 获取图片文件路径
def get_img_path(sid):
    return get_img_fold() + sid

# 获取文件夹下csv文件名称列表
def get_sid_from_fold():
    sids = os.listdir(get_csv_fold())
    correct_sids = []
    for sid in sids:
        correct_sid = sid[0: len(sid) - 4]
        correct_sids.append(correct_sid)
    return correct_sids


########## 周数据 ############
# 获取处理后的周数据
def get_week_fold():
    nowTime =  time.strftime("%Y%m%d",time.localtime(time.time()))
    return creat_fold(stk_file_path, nowTime + '/weekdata')
# 获取周数据文件路径
def get_week_file(sid):
    return get_week_fold() + '/' + sid + '.csv'
# 获取全部week文件
def get_week_sid_from_fold():
    sids = os.listdir(get_week_fold())
    correct_sids = []
    for sid in sids:
        correct_sid = sid[0: len(sid) - 4]
        #print(sid[0: len(sid) - 4])
        correct_sids.append(correct_sid)
    return correct_sids



