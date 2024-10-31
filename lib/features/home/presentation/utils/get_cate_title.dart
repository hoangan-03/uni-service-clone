String getCategoryTitle(String category) {
  switch (category) {
    case 'TODAY':
      return 'Thực đơn hôm nay';
    case 'DRINK':
      return 'Đồ uống';
    case 'FOODCOURT':
      return 'Food court';
    case 'SPECIALITY':
      return 'Đặc sản địa phương';
    case 'NECESSITY':
      return 'Nhu yếu phẩm';
    default:
      return category;
  }
}