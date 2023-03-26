# CurrencyRateApp / Waluty

This is a Flutter Android application that shows currency exchange rates.

</br>

## Views
There are 2 main views in the application:

- The main view displaying available currencies (USD, EUR, GBP, CHF).
- Detailed view divided into two sub-views containing data on the last 30 exchange rates:
  - List view.
  - Chart view.
  
Screenshots are available [below](#screenshots).

</br>

## Features
- Displaying current* exchange rate for 4 currencies.
- Displaying data for the last 30 days**, including:
  - Date.
  - Buying rate.
  - Selling rate.
  - Daily average rate.
- A chart showing the average daily rate for the last 30 days**.
- Highlighting the highest exchange rate in green and the lowest in red.
- Support for both portrait and landscape orientations.
- On every application startup, data is fetched and then stored locally. If the device does not have internet connection upon restarting the application, the saved data is displayed and an appropriate message (snackbar) is shown.
- After reconnection to the internet, data is fetched from the API.

\__________  
\*  Data comes from [api.nbp.pl](https://api.nbp.pl). The currently available data is retrieved from the API.  
** The data in the API is not updated daily, but only from Monday to Friday. The application retrieves the last 30 available data.

</br>


## Screenshots
Screenshots come from 3 different emulators.
### Portrait

**Home view**

![](/img/1.png)

**List view**

![](/img/2.png)
![](/img/3.png)

**Chart view**

![](/img/4.png)
### Landscape

**Home view**

![](/img/5.png)

**List view**

![](/img/10.png)

**Chart view**

![](/img/11.png)
