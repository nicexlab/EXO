import os  
import json  
import glob  
import numpy as np  
import matplotlib.pyplot as plt  

# 初始化总和和计数变量  

folder_stats = {str(i): {'mean': [], '99.00': [], '99.90': [], '99.99': []} for i in range(8)}  
# 指定包含 JSON 文件的根目录  
  
# 遍历每个文件夹  
for folder_name in os.listdir('./output'):  
    if os.path.isdir(os.path.join('./output', folder_name)):  
        # 遍历文件夹中的每个文件  
        for file_name in os.listdir(os.path.join('./output', folder_name)):  
            if file_name.endswith('.json'):  
                file_path = os.path.join('./output', folder_name, file_name)  
                print(file_path)
                # 读取JSON文件  
                with open(file_path, 'r') as file:
                    try:  
                        data = json.load(file)  
                        if 'jobs' in data and data['jobs']:  
                            for job in data['jobs']:
                                
                                # 检查'read'子字典和'clat_ns'下的'percentile'是否存在  
                                if 'read' in job and 'clat_ns' in job['read'] and 'percentile' in job['read']['clat_ns']:  
                                    percentiles = job['read']['clat_ns']['percentile']  
                                    # 累加所需的值  
                                    folder_stats[folder_name]['mean'].append(job['read']['clat_ns'].get('mean', 0))  
                                    folder_stats[folder_name]['99.00'].append(percentiles.get('99.000000', 0))  
                                    folder_stats[folder_name]['99.90'].append(percentiles.get('99.900000', 0))  
                                    folder_stats[folder_name]['99.99'].append(percentiles.get('99.990000', 0))
                    except json.JSONDecodeError:  
                        print("无法解析JSON文件")    
  
# 计算平均值  
for folder, stats in folder_stats.items():
    print(stats)  
    for key in ['mean', '99.00', '99.90', '99.99']:  
        stats[key] = np.mean(stats[key])  
    print(stats) 
# 绘制折线图  
plt.figure(figsize=(10, 6))  
for key in ['mean', '99.00', '99.90', '99.99']:  
    plt.plot(list(map(int, folder_stats.keys())), [stats[key] for stats in folder_stats.values()], label=key)  
  
plt.xlabel('Folder Number')  
plt.ylabel('Average Value')  
plt.legend()  
plt.tight_layout()  
plt.savefig('output_plot.png')