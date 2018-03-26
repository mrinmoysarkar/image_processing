# -*- coding: utf-8 -*-
"""
Created on Mon Feb 12 12:32:32 2018

@author: msarkar
"""

from __future__ import print_function
import torch

x = torch.Tensor(5,3)

print(x)

x = torch.rand(5,3)
print(x)

print(x.size())
y = torch.rand(5,3)

z = x+y
print(z)

x = torch.rand(4,4)
print(x)
y = x.view(16) # resize

print(y)

y = x.view(-1,2)
print(y)

if torch.cuda.is_available():
    print('cuda ase')
else:
    print('cuda nei')
    
from torch.autograd import Variable

x = Variable(torch.ones(2,2),requires_grad=True)
print(x)

y= x+2
print(y)

print(y.grad_fn)

z = y*y*3
out=z.mean()

print(z,out)

out.backward()

print(x.grad)