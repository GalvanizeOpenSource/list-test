function convertToLocalTime(date) {
  epoch = date.getTime() + parseInt(Cookies.get('timeZoneOffset'))*60*60000;
  return new Date(epoch);
}

function formatDate(date) {
  return convertToLocalTime(date).format("yyyy/mm/dd HH:MM");
}