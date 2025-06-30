import pkg_resources
import sys

def main(package_name, file_in_package_path):
    file_path = pkg_resources.resource_filename(package_name, file_in_package_path)
    print(file_path)

main(sys.argv[1], sys.argv[2])
