require "pry"
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  #binding.pry 
  index = 0 
  
  while index < collection.length do
    if collection[index][:item] == name
      return collection[index]
    end
    index += 1 
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart =[]
  index = 0 
  while index < cart.length do 
  new_cart_item = find_item_by_name_in_collection(cart[index][:item], new_cart)
  if new_cart_item != nil 
    new_cart_item[:count] += 1 
  else
    new_cart_item = {
      :item => cart[index][:item],
      :price => cart[index][:price],
      :clearance => cart[index][:clearance],
      :count => 1 
    }
    new_cart << new_cart_item
  end
  index += 1   
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0 
  while counter < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[counter][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name, 
          :price => coupons[counter][:cost] / coupons[counter][:num], 
          :count => coupons[counter][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter][:num]
    end
      
    end
    counter += 1 
  end 
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  counter = 0 
  while counter < cart.length do
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2) 
    end
  counter += 1 
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated cart = consolidate_cart(cart)
  couponed_cart = apply_coupons
end
