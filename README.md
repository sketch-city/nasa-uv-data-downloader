A way to download [Level-2 OMI Surface UV Irradiance and Erythemal Dose](https://disc.gsfc.nasa.gov/Aura/data-holdings/OMI/omuvbg_v003.shtml) from NASA.

# About the data

Data is stored in ~9005 files, some are `.he5` (`hdf`) data files and others are matching `.xml` metadata files.

# Steps

1. [Register With Earthdata Login](https://wiki.earthdata.nasa.gov/display/EL/How+To+Register+With+Earthdata+Login)
1. [Authorize NASA GESDISC DATA ARCHIVE in Earthdata Login](https://disc.gsfc.nasa.gov/registration/authorizing-gesdisc-data-access-in-earthdata_login)
1. Clone or download this repo

  ```bash
  git clone https://github.com/sketch-city/nasa-uv-data-downloader.git
  ```

1. Then run the script:

  ```bash
  ./nasa-uv-data-downloader/script.sh -u <username> -p <password>
  ```
  where `<username>` and `<password>` are from Step 1, the Earthdata login.

  You can also add a `-d` option for date.  `-d` can be any of the following:
  `2017`
  `201702`
  `20170201`
  or any other date string in the `YYYY`, `YYYYMM`, or `YYYYMMDD` format.

  By default, both `.he5` data and the corresponding `.xml` data will be downloaded.  You can add a `--without-meta` flag or `--without-data` flag to the command as needed.
