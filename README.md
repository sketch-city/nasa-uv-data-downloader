A way to download [Level-2 OMI Surface UV Irradiance and Erythemal Dose](https://disc.gsfc.nasa.gov/Aura/data-holdings/OMI/omuvbg_v003.shtml) from NASA.

# About the data

Data is stored in ~9005 `.he5` (`hdf`) files that are approximately `130MB` in size per file, the total of which right now is at least 1TB of data.

# Steps

1. [Register With Earthdata Login](https://wiki.earthdata.nasa.gov/display/EL/How+To+Register+With+Earthdata+Login)
1. [Authorize NASA GESDISC DATA ARCHIVE in Earthdata Login](https://disc.gsfc.nasa.gov/registration/authorizing-gesdisc-data-access-in-earthdata_login)
1. Clone or download this repo

  ```bash
  git clone https://github.com/sketch-city/nasa-uv-data-downloader.git
  ```

1. Then run the script:

  ```bash
  ./nasa-uv-data-downloader/script.sh <username> <password>
  ```
  where `<username>` and `<password>` are from Step 1, the Earthdata login.
