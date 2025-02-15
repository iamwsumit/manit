const navbar = `      <div class="container">
        <header class="d-flex flex-wrap py-3 mb-4">
          <a
            href=/"
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
              <a href="../contact" class="nav-link">Contact</a>
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

document.addEventListener("DOMContentLoaded", function () {
  
    const url = window.document.location.href;
    document.querySelector('#header-container').innerHTML = navbar;
    
    if (url.includes('contact')){
        document.querySelector('#contact a').classList.add('nav-active');
    } else if (url.includes('about')){
        document.querySelector('#about a').classList.add('nav-active');
    } else {
        document.querySelector('#home a').classList.add('nav-active');
    }
    
});