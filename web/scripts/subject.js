let data = {};

async function loadData() {
  try {
    const response = await fetch(
      "https://raw.githubusercontent.com/iamwsumit/manit/refs/heads/main/data.json"
    );
    data = await response.json();
    onPageLoad();
  } catch (error) {
    console.error("Error loading data:", error);
    alert("Error loading subject data");
  }
}

var lastLayoutId = "";

function onPageLoad() {
  const subjValue = getSubjParam();

  if (subjValue) {
    const subject = data[subjValue];

    if (subject) {
      const subjName = subject["name"];
      document.querySelector("h1").innerText = subjName;
      const subjData = subject["data"];

      const list = Object.keys(subjData);

      const selectComp = document.querySelector("select");

      list.forEach((e) => {
        let option = document.createElement("option");
        option.value = e;
        option.innerText = e;
        selectComp.appendChild(option);

        buildTabData(e, subjData[e]);
      });

      selectComp.addEventListener("change", (e) => {
        
        document.querySelector(`#${e.target.value}`).style.display = "grid";
        document.getElementById(lastLayoutId).style.display = "none";
        lastLayoutId = e.target.value;
      });

      document.querySelector(`#${list[0]}`).style.display = "grid";
      lastLayoutId = list[0];
    } else {
      alert("Subject not found");
    }
  } else {
    alert("Subject parameter is missing");
  }
}

function buildTabData(tab, data) {
  const container = document.createElement("div");
  container.className = "container item-container";
  container.setAttribute("id", tab);

  data.forEach((e) => {
    let title = e["title"];
    let body = e["desc"];
    let link = e["link"];
    let card = document.createElement("div");
    card.className = "item-card";
    card.innerHTML = `<div class="card-content">
        <h2 class="card-title">${title}</h2>
        <p class="card-description">${body}</p>
        <div class="button-row">
        <button class="card-btn" id="view">View PDF</button>
        <button class="card-btn" id="download">Download</button>
        </div>
        </div>`;
    container.appendChild(card);
    card.querySelector('#download').addEventListener('click', () => {
        document.location.href = link;
    });
    card.querySelector('#view').addEventListener('click', () => {
        const googleDocsUrl = `https://docs.google.com/viewer?url=${encodeURIComponent(link)}&embedded=true`;
        window.open(googleDocsUrl, '_blank');
    });
  });

  document.querySelector("#whole-container").appendChild(container);
  container.style.display = "none";
}

function getSubjParam() {
  const urlParams = new URLSearchParams(window.location.search);
  return urlParams.get("subj");
}