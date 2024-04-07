# Essential Python for DA Project

## HOMEWORK - 01 Write API to get starwars

# import library
import pandas as pd
import numpy as np
from requests import get

# create url
url_people = "https://swapi.dev/api/people/"

# create df for write JSON TO CSV
df = pd.DataFrame(
    {
        "id" : [],
        "name" : [],
        "height" : [],
        "mass" : [],
        "gender" : [],
        "homeworld" : []
    }
)

for i in range(5):
    index = i + 1
    new_url = url_people + str(index)
    res = get(new_url)
    name = res.json()["name"]
    height = res.json()["height"]
    mass = res.json()["mass"]
    gender = res.json()["gender"]
    world = res.json()["homeworld"]
    res_planet = get(world)
    homeworld = res_planet.json()["name"]
    data = pd.DataFrame({
        "id" : [str(index)],
        "name" : [name],
        "height" : [height],
        "mass" : [mass],
        "gender" : [gender],
        "homeworld" : [homeworld]
    })
    df = pd.concat([df, data])

df

# write to csv file
df.to_csv("star_war.csv")

# HOMEWORK - 02 public API
# import library
import pandas as pd
import numpy as np
from requests import get

# define api url
ur = "https://rickandmortyapi.com/api/character/"

# define get api function
def rick_morty_get(j):
  blank_df = pd.DataFrame(
      {
          "id": [],
          "name": [],
          "status": [],
          "species": [],
          "gender": [],
          "location": []
      }
  )

  for i in range(j):
    index = i + 1
    re = get(ur + str(index))
    name = re.json()["name"]
    status = re.json()["status"]
    species = re.json()["species"]
    gender = re.json()["gender"]
    location = re.json()["location"]["name"]
    rick_morty = pd.DataFrame(
        {
            "id": [str(index)],
            "name": [name],
            "status": [status],
            "species": [species],
            "gender": [gender],
            "location": [location]
        }
    )
    blank_df = pd.concat([blank_df, rick_morty])
  return blank_df

rick_morty = rick_morty_get(5)

# write to csv file
rick_morty.to_csv("rick_morty.csv")

# HOMEWORK - 03 ML with Python
# import library
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
import pandas as pd

churn = pd.read_csv("churn.csv")
