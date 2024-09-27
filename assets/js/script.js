const utilitiesContain = document.querySelector("#utilities");

const utilities = [
    {
        name: "Malwarebytes AdwCleaner",
        icon: "https://img.apponic.com/112/30/5855fda282554ed82dba613788e9d8b0.png",
        description: "The world’s most popular adware cleaner finds and removes unwanted programs and junkware so your online experience stays optimal and hassle-free.",
        link: "https://www.malwarebytes.com/fr/adwcleaner/"
    },
    {
        name: "O&O ShutUp10++",
        icon: "https://www.oo-software.com/oocontent/themes/oo2017/images/icons/front/oosu10.png",
        description: "Free antispy tool for Windows 10 and 11.",
        link: "https://www.oo-software.com/fr/shutup10"
    },
    {
        name: "Windows ISO Downloader",
        icon: "https://www.heidoc.net/php/Windows-ISO-Downloader.png",
        description: "Download genuine Windows and Office disk images directly from Microsoft's servers, in a very easy and comfortable way.",
        link: "https://www.heidoc.net/joomla/technology-science/microsoft/67-microsoft-windows-and-office-iso-download-tool"
    }
];

utilities.forEach(utility => {
    utilitiesContain.innerHTML += `
        <article>
            <div class="title">
                <img src="${utility.icon}" alt="${utility.name}">
                <h3>${utility.name}</h3>
            </div>
            <p>${utility.description}</p>
            <a href="${utility.link}" target="_blank" class="button">More information</a>
        </article>
    `;
});