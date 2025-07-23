import numpy as np
import csv

a_total = np.load('/data/home/yzb/RoboFlamingo/similarity_3b.npy')
b_total = np.load('/data/home/yzb/RoboFlamingo/similarity_7b.npy')

a = a_total[0]
b = b_total[0]
# a = np.sum(a, axis=0)/a.shape[0]
# b = np.sum(b, axis=0)/b.shape[0]

np.savetxt('similarity_3b.csv', a, delimiter=',', fmt='%d')
np.savetxt('similarity_7b.csv', b, delimiter=',', fmt='%d')

print(a.shape)
print(b.shape)

# Print the whole a matrix without truncation
np.set_printoptions(threshold=np.inf)
print(a)
print(b)

import matplotlib.pyplot as plt



plt.figure(figsize=(8, 6))
plt.imshow(a, cmap='viridis')
plt.colorbar(label='Value')
plt.title("2D Array Heatmap")
plt.xticks([])  # 隐藏坐标轴刻度
plt.yticks([])
plt.show()

plt.figure(figsize=(8, 6))
plt.imshow(b, cmap='viridis')
plt.colorbar(label='Value')
plt.title("2D Array Heatmap")
plt.xticks([])  # 隐藏坐标轴刻度
plt.yticks([])
plt.show()

# plt.figure(figsize=(10, 4))
# plt.scatter(range(len(xyz_trajectory_continue_total)), xyz_trajectory_continue_total, c='r', s=10, alpha=0.7)
# plt.title("Scatter Plot of 1D Array")
# plt.xlabel("Index")
# plt.ylabel("Value")
# plt.show()
# plt.savefig(f'/data/home/yzb/RoboFlamingo/logs_new/{model_name}/trajectory/{date}/{random_number}/continuety.png')
# plt.close()



# plt.rcParams.update({
#     'font.size': 20,          # 全局字体大小
#     'axes.titlesize': 20,     # 标题大小
#     'axes.labelsize': 20,     # 坐标轴标签大小
#     'xtick.labelsize': 16,    # X轴刻度大小
#     'ytick.labelsize': 16,    # Y轴刻度大小
#     'legend.fontsize': 20     # 图例大小
# })


# plt.figure(figsize=(8, 6), dpi=300) 
# plt.scatter(xyz_changes_dir_total, xyz_fudu_total, color='red', label='Actions')
# plt.subplots_adjust(left=0.25, right=0.95, top=0.95, bottom=0.25) 
# plt.xlabel('Action Direction Change (Cosin Value)')
# plt.ylabel('Action Magnitude')
# plt.title('RoboFlamingo 3B')
# plt.legend()
# plt.savefig(f'/data/home/yzb/RoboFlamingo/logs_new/{model_name}/trajectory/{date}/{random_number}/XYZ_Trajectory_changes_dir_with_action_norm2.png')
# plt.close()

# plt.scatter(rot_changes_dir_total, rot_fudu_total, color='red', label='Actions')
# plt.xlabel('ROT_changes_dir')
# plt.ylabel('ROT_norm')
# plt.title('ROT_Trajectory_changes_dir_with_action_norm')
# plt.legend()
# plt.savefig(f'/data/home/yzb/RoboFlamingo/logs_new/{model_name}/trajectory/{date}/{random_number}/ROT_Trajectory_changes_dir_with_action_norm2.png')
# plt.close()






