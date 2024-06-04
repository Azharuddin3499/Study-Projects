const apiKey = "b725425cd720bd0524eb5d1539421486";
const apiUrl ="https://api.openweathermap.org/data/2.5/weather?units=metric&q="

const searchbox = document.querySelector(".search input");
const searchbutton = document.querySelector(".search button");

const weathericon=document.querySelector(".weather-icon");
async function checkWeather(city){
    const response =await fetch(apiUrl+city+`&appid=${apiKey}`);
    if(response.status==404){
        document.querySelector(".error").style.display="block";
        document.querySelector(".weather").style.display="none";
    }else{
    var data = await response.json();
    document.querySelector("#c").innerHTML=data.name;
    document.querySelector("#t").innerHTML=Math.round(data.main.temp)+"°C";
    document.querySelector(".humidity").innerHTML=data.main.humidity+"%";
    document.querySelector(".wind").innerHTML=data.wind.speed+"Km/hr";

    if(data.weather[0].main=="Clouds"){
        weathericon.src="images/clouds.png"
    }else if(data.weather[0].main=="Clear"){
        weathericon.src="images/clear.png"
    }else if(data.weather[0].main=="Rain"){
        weathericon.src="images/rain.png"
    }else if(data.weather[0].main=="Drizzle"){
        weathericon.src="images/drizzle.png"
    }else if(data.weather[0].main=="Mist"){
        weathericon.src="images/mist.png"
    }

    document.querySelector(".error").style.display="none";
    document.querySelector(".weather").style.display="block"
    }
}

searchbutton.addEventListener("click",()=>{
    checkWeather(searchbox.value);
})

