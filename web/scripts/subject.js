let data = {};

async function loadData() {
    try {
        const response = await fetch('https://raw.githubusercontent.com/iamwsumit/manit/refs/heads/main/data.json');
        data = await response.json();
        onPageLoad();
    } catch (error) {
        console.error('Error loading data:', error);
        alert('Error loading subject data');
    }
}

function onPageLoad() {
    const subjValue = getSubjParam();

    if (subjValue) {
        const subject = data[subjValue];

        if (subject) {
            const subjName = subject['name'];
            document.querySelector('h1').innerText = subjName;
            const subjData = subject['data'];
            
            const list = Object.keys(subjData);
            
            const selectComp = document.querySelector('select');

            list.forEach((e) => {
              let option = document.createElement('option');
              option.value = e;
              option.innerText = e;
              selectComp.appendChild(option);
            })
            
            
        } else {
            alert('Subject not found');
        }
        
    } else {
        alert('Subject parameter is missing');
    }
}

function getSubjParam() {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get("subj");
}