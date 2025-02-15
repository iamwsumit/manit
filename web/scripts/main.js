const navbar = `      <div class="container">
        <header class="d-flex flex-wrap py-3 mb-4">
          <a
            href="/"
            class="d-flex align-items-center mb-3 mb-md-0 link-body-emphasis text-decoration-none"
            style="justify-content: center !important"
          >
            <img
              src="../assets/manit.png"
              alt="manit logo"
              height="45px"
              style="margin: 10px 20px 10px 0px"
            />
            <span class="fs-4" style="font-weight: 600"
              >MANIT Study Portal</span
            >
          </a>

          <ul class="nav nav-pills">
            <li id="home" class="nav-item">
              <a href="/" class="nav-link" aria-current="page"
                >Home</a
              >
            </li>
            <li class="nav-item">
              <a href="../assets/syllabus.pdf" target="_blank" class="nav-link">Syllabus</a>
            </li>
            <li id="contact" class="nav-item">
              <a href="https://docs.google.com/forms/d/e/1FAIpQLSdLZ65QXJPEjMZ7ggU-LTG1r2ZlMUl_j46FB4YQo4-YKHJ0vw/viewform?usp=header" class="nav-link" target="_blank">Contact</a>
            </li>
            <li id="about" class="nav-item">
              <a href="../about" class="nav-link">About</a>
            </li>
            <li class="nav-item" style="padding-left: 10px">
              <a
                href="../download/"
                type="button"
                target="_blank"
                class="btn btn-success"
                >Download</a
              >
            </li>
          </ul>
        </header>
      </div>`;

const footer = `<div class="container">
        <footer
          class="d-flex flex-wrap justify-content-between align-items-center my-4"
        >
          <div class="col-md-4 d-flex align-items-center">
            <span class="mb-md-0 text-body-secondary"
              >Made by Sumit Kumar (NITB'28)</span
            >
          </div>

          <ul class="nav-md-4 justify-content-end list-unstyled d-flex">
            <li class="ms-3">
              <a
                class="text-body-secondary"
                href="https://linkedin.com/in/iamwsumit"
                ><i class="fa-brands fa-linkedin-in"></i
              ></a>
            </li>
            <li class="ms-3">
              <a class="text-body-secondary" href="mailto:me@sumitkmr.com"
                ><i class="fa-regular fa-envelope"></i
              ></a>
            </li>
            <li class="ms-3">
              <a class="text-body-secondary" href="https://github.com/iamwsumit"
                ><i class="fa-brands fa-github"></i
              ></a>
            </li>
          </ul>
        </footer>
      </div>`;

document.addEventListener("DOMContentLoaded", function () {
  
    const url = window.document.location.href;
    document.querySelector('#header-container').innerHTML = navbar;
    
    if (url.includes('about')){
        document.querySelector('#about a').classList.add('nav-active');
    } else {
        document.querySelector('#home a').classList.add('nav-active');
    }

    document.querySelector('#footer-container').innerHTML = footer;
    
});