import { Controller } from "stimulus";
import format from 'date-fns/format'

// to do:
// clear date button
// height / styling

export default class extends Controller {
  static targets = ["overlay", "dayOverlay", "monthOverlay", "yearOverlay", "monthLabel", "yearLabel", "month", "year", "blankDay", "day", "input", "yearInput", "monthInput", "dayInput"];

  connect() {
    const selected = !!this.data.get('date')
    const date = this.data.get('date') ? new Date(this.data.get('date')) : new Date()

    this.month = date.getMonth()
    this.year = date.getFullYear()
    this.day = date.getDate()

    this.renderCal()
    this.renderSelectedDay(selected)
  }

  show(event) {
    event.preventDefault()
    this.overlayTarget.classList.remove("hidden")
  }

  close(event) {
    event.preventDefault()
    this.overlayTarget.classList.add("hidden")
  }

  changeYear(event) {
    event.preventDefault()
    this.dayOverlayTarget.classList.add("hidden")

    this.renderSelectedYear()
    this.yearOverlayTarget.classList.remove("hidden")
  }

  selectYear(event) {
    this.year = parseInt(event.currentTarget.innerText)

    this.yearOverlayTarget.classList.add("hidden")

    this.renderSelectedMonth()
    this.monthOverlayTarget.classList.remove("hidden")
  }

  selectMonth(event) {
    this.month = parseInt(event.currentTarget.getAttribute('data-value'))

    this.monthOverlayTarget.classList.add("hidden")
    this.dayOverlayTarget.classList.remove("hidden")

    this.renderCal()
    this.renderSelectedDay(false)
  }

  nextMonth() {
    this.year = this.month == 11 ? this.year + 1 : this.year
    this.month = (this.month + 1) % 12

    this.renderCal()
    this.renderSelectedDay(false)
  }

  prevMonth() {
    this.year = this.month == 0 ? this.year - 1 : this.year
    this.month = (this.month - 1 + 12) % 12

    this.renderCal()
    this.renderSelectedDay(false)
  }

  daysHelper(year, month) {
    // the 3rd arg asks for the -1th day of the month given, "month + 1"
    // so the result is the last day of the "month" we want
    const lastDayOfMonth = new Date(year, month + 1, 0)
    const daysInMonth = lastDayOfMonth.getDate()

    const firstDayOfMonth = new Date(year, month, 1)
    const firstDayOfMonthWDay = firstDayOfMonth.getDay() // 0 = sun, 6 = sat

    return [firstDayOfMonthWDay, daysInMonth]
  }

  selectDay(event) {
    this.day = parseInt(event.currentTarget.innerText)

    this.overlayTarget.classList.add("hidden")

    this.renderSelectedDay()
  }

  renderSelectedMonth() {
    this.monthTargets.forEach((el, i) => {
      if (i == this.month) {
        el.classList.remove("text-gray-700", "hover:bg-blue-200")
        el.classList.add("bg-blue-500", "text-white")
      } else {
        el.classList.add("text-gray-700", "hover:bg-blue-200")
        el.classList.remove("bg-blue-500", "text-white")
      }
    })
  }

  renderSelectedYear() {
    this.yearTargets.forEach((el, i) => {
      if (el.getAttribute("data-value") == this.year) {
        el.classList.remove("text-gray-700", "hover:bg-blue-200")
        el.classList.add("bg-blue-500", "text-white")
      } else {
        el.classList.add("text-gray-700", "hover:bg-blue-200")
        el.classList.remove("bg-blue-500", "text-white")
      }
    })
  }

  renderSelectedDay(selected = true) {
    // reset day if date isn't valid (31st Feb)
    const daysHelperResult = this.daysHelper(this.year, this.month)
    const daysInMonth = daysHelperResult[1]
    this.day = this.day > daysInMonth ? daysInMonth : this.day

    this.dayTargets.forEach((el, i) => {
      if (i == this.day - 1) {
        el.classList.remove("text-gray-700", "hover:bg-blue-200")
        el.classList.add("bg-blue-500", "text-white")
      } else {
        el.classList.add("text-gray-700", "hover:bg-blue-200")
        el.classList.remove("bg-blue-500", "text-white")
      }
    })

    if (selected) {
      this.yearInputTarget.value = this.year
      this.monthInputTarget.value = this.month + 1 // this is being sent to ruby which does months from 1..12
      this.dayInputTarget.value = this.day

      this.inputTarget.value = this.formatDateAsLong(new Date(this.year, this.month, this.day))
      const event = new Event('date-picker-changed');
      this.inputTarget.dispatchEvent(event);
    }
  }

  renderCal() {
    // month + year
    this.monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    this.monthLabelTarget.innerText = this.monthNames[this.month]
    this.yearLabelTarget.innerText = this.year

    // days
    const daysHelperResult = this.daysHelper(this.year, this.month)
    const firstDayOfMonthWDay = daysHelperResult[0]
    const daysInMonth = daysHelperResult[1]

    this.blankDayTargets.forEach((el, i) => {
      if (i < firstDayOfMonthWDay) {
        el.classList.remove('hidden')
      } else {
        el.classList.add("hidden")
      }
    })

    this.dayTargets.forEach((el, i) => {
      if (i < daysInMonth) {
        el.classList.remove('hidden')
      } else {
        el.classList.add("hidden")
      }
    })
  }

  formatDateAsLong(d) {
    return format(d, "E do MMM, yyyy")
  }
}
