from SALib.sample import saltelli
from SALib.analyze import sobol
from SALib.test_functions import Ishigami
import numpy as np

# 定义模型输入
problem = {
    'num_vars':3,
    'names':['x1','x2','x3'],
    'bounds':[[-3.14159265359, 3.14159265359],
              [-3.14159265359, 3.14159265359],
              [-3.14159265359, 3.14159265359]]
}

# 使用saltelli生成样本
param_values = saltelli.sample(problem,1024)

Y = Ishigami.evaluate(param_values)

# 分析
Si = sobol.analyze(problem,Y,print_to_console=True)

Si.plot()

