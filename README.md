# Rails Trivago Clon

## Public website

The app should have a public website without a namespace.

- Authentication with email and at least two social networks
- List of hotels with their promotions if they have
- Search available rooms in a range of dates by price (min and max) and amount of beds
- Book a room for a range of dates if it's not reserved between those dates
- Send a confirmation email to the user after a new booking is created
- Send an email to the hotel email
- List user bookings in a table
- (optional) User should be able to cancel a booking from their list of bookings
- Send an email the previous day of the booking to the user
- Rooms should have many images
- Hotels should have many images
- (optional) If the user accessed the show view of a room save a cookie the hotel of the room and when going to the list of hotels display those hotels first as recommended, save up to 5 different hotels and then removed the oldest one, this list of recommended hotels should be ordered with the last visited first.

## Administration panel

The app should have an administration panel in the namespace `/admin`.

- Register a new hotel
- Add a room to an hotel
- Deregister a hotel, and remove related rooms
- Notify clients with bookings about the delete
- Metrics about most popular and less popular hotels (option to delete less popular with a single click)
- Create promotion for a hotel or room and apply a percentage or fixed amount of discount

## Public API

The app should expose an API in `/api` to recreate the public website.

- Token based authentication (normal token or JWT with invalidation)
- All resources should be exposed
- Admin users should be able to create, update and delete resources as in the admin
- Customer users should only be able to read, search and create and delete bookings
- Search with query to filter by amount of beds and price (min and max)
- Endpoint to book a room as the current user, receive range of dates as params
- It must have tests

## Resources

- Hotel (name, email, city, country, address, images)
- Room (name, amount_of_beds, hotel_id, price, images)
- User (name, email, password, role)
- Booking (start_date, end_date, user_id, room_id)
- Promotion (start_date, end_date, discount_type, discount_amount, promotionable_type, promotionable_id)

![](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/8e9694a8-7691-425e-bc1e-5e5cbda2cfab/Image_2019-04-26_at_5.42.45_PM.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAT73L2G45DSQFP6UC%2F20190429%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20190429T142426Z&X-Amz-Expires=86400&X-Amz-Security-Token=AgoJb3JpZ2luX2VjEHUaCXVzLXdlc3QtMiJHMEUCIQCb78JiHZfKtCqcYBV8BRz6wH4utuEyH9tc6Z1Jhp7wxAIgLsVASvD1HDHsLf2EYPFt5fDcJeWrUS3GvfQSoIsfqHsq2gMIXhAAGgwyNzQ1NjcxNDkzNzAiDJav3HykrClPIyYZfCq3AyawPtuOHhBH6f4IMnV1HTrCR9QO6fdZC2f3x3e%2FSb8BR8HbKcFl53i6ZbOcUv5ylJOzzk1BeRhoNXjhLKtAxwDrglFq%2B%2F0%2FRdznjEsmERhaL4fZpJDlxUwlHvHHo6yuv1%2FBKXt0BrrtYM8dwjItvxLLSynx2ZxFv7TKPIkt%2BCIS6RkRUeL9Qj%2B6GtW9u5V4JbWvr%2BkTOiHCdRpm8rxo96qAppmnxYq4PwXxyAOIxOtADxkBZy5Cpt6yRRZh9y0Yb1TVgIgqvK5XEXVShQKM7vbHNeC45uhLBBwIAsjTe54EmVmsct9roTi1XGMfiHo0%2BEESdRErbsvNYqALxvdY4nQ%2FQowgRyMHeNMW8aV3IeiiyL2My1pv9i%2Byp95tkEJbKCwXlozbjx6qEyeVS05g7QSzIFSR34OMKC0mrL9T8b3e%2FD6Q1D1MB6Tb73PNHvG8%2BKeLKMUigkYIydGISkKjdlodF8Dh8ewt2LMKwQN83LHACPzrb%2Fia5zS1X3a3QxJQUZs9LJ4wcWUAgx2%2FAeU%2BbSYGzjLAdRg0ctoXjuE58v%2BuabUgzV8kJwZltOUnYEN2mpytf85X5R4w8eSb5gU6tAEIBti%2BNzfhUmZL2pIuAuAQV6U7YTxQfAk8hD1tQ0id8Kaqq4xZlyeRgKWaCSn0y14M3xL%2FEplR9TGkau7kKJVHqiQxwZe%2FnCXU7nLf4BJRLN%2FS%2F4dznc37Jf5OWYnS6umhPDCU3%2FNslrx22YQacTIcEDl84jkBRTcMHvFq%2B78BjYpnFyuSOBXJbt%2B5XEF6vmNQUpMF%2Bd7j4qoQ%2BBgVReL%2BrAzbKn9iE3JhRfoGz2fvGTx%2FNlE%3D&X-Amz-Signature=769c1ec0de5b5e0e477c3d7efbc557f0a6743bffa7a1dab8cc3453a40489bce4&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Image_2019-04-26_at_5.42.45_PM.png%22)

## Acceptance Criteria

- The API must have tests
- Errors should be displayed to the users with understandable messages
- Non optional features are required
- Project lead must ask doubts about the features
