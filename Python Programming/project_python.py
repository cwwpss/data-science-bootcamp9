# Project Python 101 for DA

## HOMEWORK - 01 Pao Ying Chub Game
# import random choice from random
from random import choice

# create function for game
def pao_ying_chub():
  user_name = input("What is your name?")
  print("Hi! " + user_name)

  # define score variable
  user_score = 0
  com_score = 0
  hand = ["rock", "paper", "scissors"]

  while True :
    # define user and com pick hand variable
    user_pick = input("Choose your hand!")
    com_pick = choice(hand)

    # Win lose draw condition
    if user_pick == com_pick:
      print("Computer pick the " + com_pick + "!")
      print("Draw!!")
    ## define com win condition
    elif (user_pick == "rock" and com_pick == "paper") or (user_pick == "paper" and com_pick == "scissors") or (user_pick == "scissors" and com_pick == "rock"):
      com_score = com_score + 1
      print("Computer pick the " + com_pick + "!")
      print("You lose this round!! Try again😁")
      print("Your score is " + str(user_score))
      print("Com score is " + str(com_score))
    ## define user win condition
    elif (user_pick == "rock" and com_pick == "scissors") or (user_pick == "paper" and com_pick == "rock") or (user_pick == "scissors" and com_pick == "paper"):
      user_score = user_score + 1
      print("Computer pick the " + com_pick + "!")
      print("You win this round!!")
      print("Your score is " + str(user_score))
      print("Com score is " + str(com_score))
    elif (user_pick == "stop"):
      if (user_score > com_score):
        print("You win!! Congrat🎉🎉")
      elif (com_score > user_score):
        print("You lose! Try again next time✌")
      else:
        print("Draw! you're so good. see you next time")
      break

pao_ying_chub()

# HOMEWORK - 02 OOP create DA class
class DA:
  def __init__(self, name, age, position, exp, salary, company):
    self.name = name
    self.age = age
    self.postion = position
    self.exp = exp
    self.salary = salary
    self.company = company

  def up_position(self, new_position):
    self.postion = new_position
    print("My new position is " + new_position)

  def new_salary(self, percentage):
    self.salary = self.salary*(1+percentage)
    print("My new salary is " + str(self.salary) + " Baht")

  def exp_growth_up(self, year):
    self.exp += year
    print("I have work experience " + str(self.exp) + " year")

  def job_rotation(self, new_com, new_sal, new_pos, new_exp):
    self.position = new_pos
    self.salary = new_sal
    self.exp = new_exp
    self.company = new_com

da01 = DA("tom", 28, "senoir", 3, 50000, "gg company")

da01.up_position("Manager")

da01.new_salary(0.3)

da01.exp_growth_up(3)

da01.job_rotation("bb comoany", 100000, "Manager", 0)

print(da01.name, da01.age, da01.position, da01.exp, da01.salary, da01.company)

