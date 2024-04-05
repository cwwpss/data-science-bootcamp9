# R programming project
## Homework - 01 Game Pao Ying Chub
pao_ying_chub <- function() {

  # Greetings player
  player_name <- readline("Hi! what is your name: ")
  text_wel = paste("welcome to the game", player_name)
  print(text_wel)
  player_score <- 0
  com_score <- 0

  # Game pao ying chub
  while (TRUE) {
  flush.console()
  player_hand <- readline("Choose your hand: ")
  show_player_hand = paste("Your hand:", player_hand)
  com_hand <- sample(c("rock", "paper", "scissors"), 1)

  ## score and exit
  if (player_hand == "stop") {
    if (player_score > com_score) {
      print("You win😎, congrats🎉")
    } else if (player_score < com_score) {
      print("You lost😥, let's try next time.👏")
    } else {
      print("Drawwwww!🥓🥓")
    }
    print("See you soon")
    break
   } else if ((player_hand == "rock" & com_hand == "paper") | (player_hand == "paper" & com_hand == "scissors") | (player_hand == "scissors" & com_hand == "rock")) {
     print(show_player_hand)
     print(paste("Com hand:", com_hand))
     com_score = com_score + 1
     print(paste("Com win this round!, com score:", com_score))
   } else if ((player_hand == "rock" & com_hand == "scissors") | (player_hand == "paper" & com_hand == "rock") | (player_hand == "scissors" & com_hand == "paper")) {
     print(show_player_hand)
     print(paste("Com hand:", com_hand))
     player_score = player_score + 1
     print(paste("You win this round!, you score:", player_score))
   } else if (player_hand == com_hand) {
     print(show_player_hand)
     print(paste("Com hand:", com_hand))
     print("Draw!")
   } else {
     print("Error, please try again.")
   }
 }
}
pao_ying_chub()

## Homework - 02 Pizza Restaurants

## create menu and price
pizza_df <- data.frame(
    id = 1:10,
    menu = c("Margherita Pizza", "Hawaiian Pizza", "Meat Feast Pizza", "Smoked Salmon Pizza", "Pepperoni Pizza", "Caesar Salad", "Garlic Bread", "Cheesy Breadsticks", "Chicken Wings", "Coke"),
    price = c(10.99, 10.99, 12.99, 13.99, 10.99, 8.49, 4.49, 5.99, 8.99, 2.59)
  )
grand_total <- 0
i <- 0

pizza_restaurant <- function () {
 # greeting and show the menu.
  while (TRUE) {
  flush.console()
  show_menu <- readline("Hello, What would you like, sir? Do you want a menu? ")
  if (show_menu == "yes") {
    print(pizza_df)
    break
  } else if (show_menu == "no") {
    print("Good bye, see your next time.")
    break
  } else {
    print("error command. Please try again!")
    }
  }
  # create blank df for store order
  order_df <- data.frame(
    menu = character(),
    price = numeric()
  )

  # reseive order
  while (TRUE) {
  if (show_menu == "no"){
    break
  }
  flush.console()
  reseive_order <- readline("What would you like to have?")

  if (reseive_order == "stop") {
    print(order_df)
    print(paste("Here’s your bill, sir. It’s", grand_total))
    print("Thank you sir.")
    break
  } else if (reseive_order %in% pizza_df$menu | reseive_order %in% pizza_df$id)
    {
    if (reseive_order %in% pizza_df$id) {
      order_df[nrow(order_df) + 1, ] = c(
        pizza_df[(pizza_df$id == reseive_order),][["menu"]],
        pizza_df[(pizza_df$id == reseive_order),][["price"]]
        )
      grand_total = grand_total + pizza_df[(pizza_df$id == reseive_order),][["price"]]
      print(paste("You current bill is", grand_total))
    } else if (reseive_order %in% pizza_df$menu) {
    order_df[nrow(order_df) + 1, ] = c(
        reseive_order,
        pizza_df[(pizza_df$menu == reseive_order),][["price"]]
        )
      grand_total = grand_total + pizza_df[(pizza_df$menu == reseive_order),][["price"]]
      print(paste("You current bill is", grand_total))
    }

  } else {
    print("error command. Please try again!")
  }
}
}

pizza_restaurant()
